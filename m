From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 17:47:47 +0200
Message-ID: <CABPQNSZayAr0jf9C55wtEH_AJ_hSUkwFsGV4ZxVixizthojkRA@mail.gmail.com>
References: <ygfvbpqooog.fsf@corbe.net> <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
 <53F135F8.60508@gmail.com> <ygflhqlvni7.fsf@corbe.net> <CABPQNSZ=BKqNPCWUmaCSz+gJtBRhjkWtpcDbirsV+KJX=c0kpg@mail.gmail.com>
 <ygf7g25vm9v.fsf@corbe.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 17:48:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJPAu-0002nm-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 17:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbaHRPs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 11:48:28 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:65367 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbaHRPs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 11:48:28 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so8120109igd.8
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=KmKe51pbG09RZoh9Zse5uHhGqBJr5pXDGOLW5YfwbeM=;
        b=QVxOXOV5ODLN7Gx57FPGQyCYQPfTWFNUfV7r803s//FLf8mxY+xeGOiSKk//APHIIt
         Pk7DW+4iP5BYhAhrUL6zTyxKpbwRvE6pEnB1P8vyEvlFKF7GNVTgb+q04uEnIhbfKRKY
         0a2OkyPXEHF6W7aNdGFYuYAUjySayCLmnS8D2u1aCjjaIPqTKZLtCLCO9YDf/Gd2d4hp
         ZV8aPFmsOSHjr13G8LXwtVcGSwWVR5Vp17FQdMaaEs216TmjBOKkT2uYE0rzqrvwXCKX
         RdbMMkhAZu9t0NwfgZ5W+athWHuw5ACPzg+KjDLj3eeEcXtnr3ENzu68qIOHmqz3cZod
         0GNw==
X-Received: by 10.50.33.73 with SMTP id p9mr83684568igi.24.1408376907453; Mon,
 18 Aug 2014 08:48:27 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Mon, 18 Aug 2014 08:47:47 -0700 (PDT)
In-Reply-To: <ygf7g25vm9v.fsf@corbe.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255393>

On Mon, Aug 18, 2014 at 5:40 PM, Daniel Corbe <corbe@corbe.net> wrote:
>
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> Or you could just restart your shell when you disconnect...
>
> Well I'm not that daft.  I tried that and if it had resolved my problem
> I wouldn't have posted.

Hm, but isn't that what Karsten explains in his last paragraph? What
shell are you running msys or cmd?
