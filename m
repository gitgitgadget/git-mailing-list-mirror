From: Alex K <spaceoutlet@gmail.com>
Subject: deleting / adding files throughout the repository
Date: Mon, 8 Jun 2009 18:25:00 +0100
Message-ID: <e4a904790906081025s76bdd1a0k73003e861da98371@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 08 19:27:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDid5-0006CF-1F
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 19:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZFHRZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 13:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbZFHRZA
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 13:25:00 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:61421 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbZFHRY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 13:24:59 -0400
Received: by fxm9 with SMTP id 9so2354392fxm.37
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=GAoyoJGmnmpVSaoRiZ4VROtSAkbaC+nm4Qcs3K3M8KM=;
        b=ErODHMWxqD0CJNLfGU7GDBYxkpWGrIZF/e0FTWWkv9NPfQknTnbrocESqe4/cREhkc
         QODSSZESiIwuhZiBbN6pY5xQtKi+kOhNpMsNSKahADtviSEpm4lS4T0lE2l62lAIeJvj
         ++0RHychfnlUhnAyFpH1VcAGzMaLrrqvT7IcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=i9eEgCIdo9ACyETa8lkzCzVKXH0mgadf1WJwun1q6pH0NgjwgyLJJPIcHr3nub7mIs
         mZr44GEcD/ZgQj5KluoYERr42chpa4bbm9dAGn7tqUgvULGyqUsjvbmZ3JV2BrsCijlU
         UsJ+NQ+Igj9SHjj/iF7YbqeLBzxmotoQCwV8w=
Received: by 10.204.116.8 with SMTP id k8mr6895643bkq.117.1244481900582; Mon, 
	08 Jun 2009 10:25:00 -0700 (PDT)
X-Google-Sender-Auth: 1b8f01657ad2452d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121091>

Hello,

Suppose I made a mistake in my repository. There is a file that should
never have been there. How do I delete this file from the entire
repository history? How do I add a file throughout the entire
repository history as if this later file had always been there?

Thank you,

Alex
