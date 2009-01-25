From: Dill <sarpulhu@gmail.com>
Subject: Translations in Git release?
Date: Sun, 25 Jan 2009 10:41:02 -0700
Message-ID: <60646ee10901250941s34f7accem1b74fc201e895a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 18:42:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR90Y-0005jG-2X
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 18:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbZAYRlG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 12:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbZAYRlF
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 12:41:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.227]:56965 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbZAYRlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 12:41:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5515496rvb.1
        for <git@vger.kernel.org>; Sun, 25 Jan 2009 09:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Cdd9H1vAY5ts4LQIhBxe5zY2li+ZuHWYUGTvr1vn1Pg=;
        b=dJoelKKW9HLaoRsVnFQ4QZshLKJo1W/hTplzONs+wUY2dE79Z6YE5lkhT7TOctDFvJ
         M4aleAiDPpW5WkXPeDyzdxiGdNQrCpnTPIzDMbxLlqoY2VDEFXNVMvfAEdnqat3Yg7LJ
         Cn6rvbUNcwE7A7wHiwIIqSAJiBKKLkn3Tw2B0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=reJNpCKnH7XyL+sHOFk1A4E3uSagqD86irhixnAzn8veJeJkY18DdG+c/c4nM4IbjL
         8y0AZCsQ5+h7SQfVGVSAirkiVD+tnyRCdEm1snmymYlofgrCV/fYOMHIbW5PvtkxuMqw
         vVXiXpewffA2c8Ubc3P8i6bpTD7n3OPRPa9Xg=
Received: by 10.141.37.8 with SMTP id p8mr1204853rvj.227.1232905262606; Sun, 
	25 Jan 2009 09:41:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107068>

Is there a plan to include translations of the Documentation within
Git or should they exist outside of the project?
