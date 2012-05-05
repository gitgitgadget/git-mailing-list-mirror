From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: UI issues
Date: Sat, 5 May 2012 17:59:13 +0200
Message-ID: <CAMP44s1qMaP_upA+UG+FkvfwfhtO7wFt6+NRiYYPNe3iH9C2ZQ@mail.gmail.com>
References: <CAHVLzc=xynGv=Mhr2yW4=GaLxX=W6xMQS9bosrvCCo8tHZjarA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes.Schindelin@gmx.de
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 17:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQhOB-0001uW-OI
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 17:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443Ab2EEP7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 11:59:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36086 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab2EEP7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 11:59:14 -0400
Received: by eekc41 with SMTP id c41so1077260eek.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 08:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MDxXi5hK4IlTtmwibrqUyX4xtQyid9QoqG4Ld3tuhOA=;
        b=X05OXy8V7K9zjUdSbzhCnxK052FsrgQ/bPe+q0TfDS8T7ZB/YJlEEXyH0+GhDMU8t7
         UYhmO1yNfRrqwIFbADByUveuoj5XU3oM+04UHjAwlbB9XK6NA4lH8TALrOumuu1eDc4l
         ryivIW1mKxQEeylZxRXdbF2RNJTKe6F3UbStk28J04RetJtACTgAHc6/YtK7Hf/dL+yT
         pxEjH3METvQGpPEjTFeYUJ7qZ1IZnSVbShi1P5OpX5KlhG9jOYKvMUfgrdpr8HZPuhnW
         fI0bCCqkJsGrV5Rmf/1ARV701piWIZLIq3E9BfdbM6ubdWjYlAwuiIXL6ndzHnLJz9lr
         Xnkw==
Received: by 10.213.28.208 with SMTP id n16mr1834546ebc.106.1336233553704;
 Sat, 05 May 2012 08:59:13 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sat, 5 May 2012 08:59:13 -0700 (PDT)
In-Reply-To: <CAHVLzc=xynGv=Mhr2yW4=GaLxX=W6xMQS9bosrvCCo8tHZjarA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197120>

On Thu, Apr 26, 2012 at 10:47 AM, Paolo Ciarrocchi
<paolo.ciarrocchi@gmail.com> wrote:
> Hi,
> in a interesting discussion in G+ Dscho raised a few issues in the GIT UI.
> I think there is value in summarizing the thread and opening a new
> discussion here:
> - short names for uncommon operation, long names for common ones (e.g.
> cherry vs cherry-pick)
> - lack of undo
> - the usual discussion about the terms index, staging area and the
> "add" command. They all look not consistent.
> - 'git remote' has sub commands 'rename' (but not 'mv') and 'rm' (but
> not 'remove')
> - git remote add -f blub WRONG_URL fails but you still have to remove
> the remote before you can try again to add something.

So they are not lost:
https://git.wiki.kernel.org/index.php/UiIdeas

-- 
Felipe Contreras
