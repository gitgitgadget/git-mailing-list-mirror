From: Sergey Yanovich <ynvich@gmail.com>
Subject: git tool to keep a subversion mirror
Date: Mon, 18 Jun 2007 15:14:01 +0300
Message-ID: <11821688443683-git-send-email-ynvich@gmail.com>
To: git@vger.kernel.org, normalperson@yhbt.net, Matthieu.Moy@imag.fr
X-From: git-owner@vger.kernel.org Mon Jun 18 14:13:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0G6a-0007ke-Pm
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 14:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761439AbXFRMNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 08:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760881AbXFRMNH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 08:13:07 -0400
Received: from hu-out-0506.google.com ([72.14.214.224]:57504 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760597AbXFRMNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 08:13:06 -0400
Received: by hu-out-0506.google.com with SMTP id 19so722651hue
        for <git@vger.kernel.org>; Mon, 18 Jun 2007 05:13:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EgnvKjiaPjf0QwqNCpP7wAJolhKxQ3J0Hajg+ACPfov8MECI7kwZgUhPmft9ligRMeIwczJFC9uI16UEszfoyTnpk3q+m5nhMlSDJ2PRyFw5W8quVIm6ddy0qDi41/kQcbmWOC21AcsVz5Ibg7sTwcHVQlPf7rkL5jQaPQj5U7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jZAsKugw3jVx8XAbWbythvgkhjcFTKR012UgBUp3QYJ3e0GB6Lwv3QgLK+vCJDBEGd3yK8xa+tyxTE6hx6nRZ2qho6IyUBXb5PEkcbqLCkCXtKYwYQLyXunui3we2IMYvP2z8sgWfkSL1Uc0MOXJE2s532zBRi5HPdqaclQZzSA=
Received: by 10.82.160.2 with SMTP id i2mr11124056bue.1182168784702;
        Mon, 18 Jun 2007 05:13:04 -0700 (PDT)
Received: from host3 ( [87.252.237.202])
        by mx.google.com with ESMTP id z33sm14697764ikz.2007.06.18.05.13.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jun 2007 05:13:03 -0700 (PDT)
Received: from sergei by host3 with local (Exim 4.63)
	(envelope-from <ynvich@gmail.com>)
	id 1I0G7S-0001Ru-GM; Mon, 18 Jun 2007 15:14:06 +0300
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: vpqhcp6b85c.fsf@bauges.imag.fr
References: vpqhcp6b85c.fsf@bauges.imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50390>

On 6/18/07, Sergey Yanovich <ynvich@gmail.com> wrote:
> However, '--chain-reply-to' seems to have failed. The patches (2 of
> them) came as top-level posts. Or I may be doing something wrong.

I should have used '--thread' and '--in-reply-to=' when I was formating
the patches. It should be correctied this time.

Sorry for being akward :)

--
 Sergey Yanovich
