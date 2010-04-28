From: Bryan Richardson <btricha@gmail.com>
Subject: See commits on remote repository
Date: Wed, 28 Apr 2010 16:35:32 -0600
Message-ID: <n2v3f81a4241004281535h30d35f5cw5f33e265d19d35b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 29 00:35:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7Fr2-0007nl-L9
	for gcvg-git-2@lo.gmane.org; Thu, 29 Apr 2010 00:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab0D1Wfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 18:35:34 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:43660 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0D1Wfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 18:35:33 -0400
Received: by iwn12 with SMTP id 12so4621022iwn.15
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 15:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=t8R7PPNRrB07d5guxa2W0dz8/JgpIZHzD/gU/mNCP1k=;
        b=FNj+c1/z8zpIq/AIgjIpGUD37YXhaeBwYpTF4K2ACvg2YTR7AYM4HJRGntwjgByUp+
         2eMGwz4j31VaezWWc0xOBAiLhw541lu+dEopODb16/VGMEo5fnR0AfDct57XnbH5KJyy
         867UJ8LmdqDhjXEci0Ajw9RJVmDRI26DD8Uho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=cj7cRDKGXTYGBMZtWr7NnkbCZbfh8UTGyK607MqNdrMZ7QXQK6zAN9ScRNPEuPIewq
         1FtFXXNwCD0o6pTWkqwEJRNz4Erj/mW+Ac5BvKIJk9nOpql9Neg9wqQlBzwngH8R7n9i
         Q9XZoQgXRCbkMLtJV2oPSSkNeccuw1XU5EsLM=
Received: by 10.231.170.143 with SMTP id d15mr3121473ibz.13.1272494133026; 
	Wed, 28 Apr 2010 15:35:33 -0700 (PDT)
Received: by 10.231.36.203 with HTTP; Wed, 28 Apr 2010 15:35:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146016>

Hello All,

Sorry if this question has been asked already. This mailing list is
crazy active, and even after searching I couldn't find anything.

Is it possible to show commits to a remote repository that was created
as a clone of a local repository, similar to how GitHub lets users
view commits made to forked projects in a project's network?

For example, say I have repository X, which I do a bare clone on to
create repository Y for someone else to work on (effectively forking
repo X). Is there a way for me to see, from repository X, what commits
have been made to repository Y?

--
Thanks!
Bryan
