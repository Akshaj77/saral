class BasicApiConstants {
  static const String BASE_URL = 'https://eb39-122-163-5-33.ngrok-free.app/api/tasks';
  static const String API_KEY = '3c1d52a72c363c1055b2891e580a9b26d6c5de2a042b7eb407da82d3c657a4f88b549773c740f590f8cb8a8995e3bdf9942e12a6b19ee9a545351ecf369f68a1c159755c77b424c3c4c1635ecc7c14afdfcb25902df757848335e379f6ccb925d4db2846e16b82381fc0b15974e3555ce6ff6203069959e16b82bb16660d4856';
  static const String GRAPHQL_URL = 'https://eb39-122-163-5-33.ngrok-free.app/graphql';
}

class QueryConstants {
  static const String updateCompletedMutationquery = """
  mutation UpdateTaskCompleted(\$id: ID!, \$completed: Boolean!) {
  updateTask(id: \$id, data: { Completed: \$completed }) {
    data {
      id
      attributes {
        Title
        Description
        Completed
        createdAt
      }
    }
  }
}
""";

static const String addTaskMutation = """
   mutation AddTask(\$title: String!, \$description: String!, \$completed: Boolean!, \$publishedAt: DateTime!) {
    createTask(data: { Title: \$title, Description: \$description, Completed: \$completed, publishedAt: \$publishedAt }) {
      data {
        id
        attributes {
          Title
          Description
          Completed
        }
      }
    }
  }

    
  """;

  static const String deletTaskMutation = """
  mutation DeleteTask(\$id: ID!) {
  deleteTask(id: \$id) {
    data {
      id
      attributes {
        Title
        Description
        Completed
        publishedAt
      }
    }
  }
}

  """;
}