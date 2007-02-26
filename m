From: "Mike Coleman" <tutufan@gmail.com>
Subject: Trivia: When did git self-host?
Date: Mon, 26 Feb 2007 17:51:13 -0600
Message-ID: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 00:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLpcw-0007HZ-S0
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 00:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161423AbXBZXvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 18:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161430AbXBZXvS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 18:51:18 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:28242 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161423AbXBZXvP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 18:51:15 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1938332nfa
        for <git@vger.kernel.org>; Mon, 26 Feb 2007 15:51:14 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CCAgSX2TXyGvkWrHBbKmI1Wz3Dtp8RBCzK4Xu1mO5tPAhIkHsNdcytgThrJSD7RYEjUxJTGCz97sqDuq5GOkWj0PHYauemNl54piB9ruaYCcqoN44tPqEb9+dhY1AdJa5xVMt5t5wu2OLjwW5ylZXaYqj8nVRVdo8RS00uL6dSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O7ObaPlRyOVHn5KB45YI+hYIjUYQ3HfmQ3KJZocoGKhMpX6nkAqt2kDbwG5M4ETOfGTO6psdnDYBI1DD9PZjkyTYCnbjfhZSH6yP5Par0fhKN0x0DS6LVVoa4IGXmWqBQbi1DojmbZUNTlR0yBvRYa3lBzoURlgxHO0ZxFatEQY=
Received: by 10.49.65.19 with SMTP id s19mr13769031nfk.1172533873952;
        Mon, 26 Feb 2007 15:51:13 -0800 (PST)
Received: by 10.49.92.17 with HTTP; Mon, 26 Feb 2007 15:51:13 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40673>

Does anyone recall when git first self-hosted?  This doesn't seem to
be present on the GitHistory page on the wiki, and I'm not finding it
elsewhere.

I suppose this could mean different things, but roughly I'm curious
about the earliest point at which all further commits were
human-generated, in real time, as opposed to the machine-generated
commits of some robo-import script.  I'm not seeing this transition in
the git-log, which seems to go continuously back to the very beginning
(which is a little disturbing :-).

Mike
