From: Jack Desert <jackdesert556@gmail.com>
Subject: GIT counterpart to "svn list"
Date: Wed, 21 Apr 2010 22:22:37 -0500
Message-ID: <20100421222237.1758ca66@pennie-farthing>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 05:22:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4n05-0002iI-8n
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 05:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab0DVDWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 23:22:42 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46819 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab0DVDWl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 23:22:41 -0400
Received: by gyg13 with SMTP id 13so4196081gyg.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/hpJqJXy9d5VFKXPStBsLgwqkoAg9vMIPiXC0qiysfk=;
        b=k7sgpWzcXThWAX+Ilv+M1CQzgJJgkT1cu/lt380VmfCWd/1YWCq5ZmhTWDDen9bXeL
         urA7FpbPdP2Iri6qZ6QHHj8Rl683J4DjPYun7DZHmHUA6HhPOFuasR6+MHwgR9wCs8PH
         8Wtfw9+mQqyjvnwjTI9g3uPBxsoZdID6o/mfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=ugUBWmb47dhKZBvdGt3vx1ydGKWVmiexHHPRIpc9ldD6omWfxQFvn1F4HJ9xsMCFU+
         jEYjti32G/I9G1Op1wQeqoOcOig87p2CNgVeL7ZMO69DpgaUCC71YuR2kuf6tUSklgFt
         efM3hfhO2wUKi4TTeRkmfcmtGXYXKphuL3xWI=
Received: by 10.101.139.6 with SMTP id r6mr22762882ann.14.1271906560913;
        Wed, 21 Apr 2010 20:22:40 -0700 (PDT)
Received: from pennie-farthing (oh-76-1-213-69.dhcp.embarqhsd.net [76.1.213.69])
        by mx.google.com with ESMTPS id 20sm809095iwn.1.2010.04.21.20.22.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 20:22:40 -0700 (PDT)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.3; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145495>


I'm new to GIT, and the one command I can't live without is:
  svn list
Is ther a GIT couterpart to svn list?

-Jack


-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jack Desert     --    Writer, Entrepeneur
Author and Spokesman: www.LetsEATalready.com
Software Developer:   http://GrooveTask.org
Email: JackDesert556@gmail.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
