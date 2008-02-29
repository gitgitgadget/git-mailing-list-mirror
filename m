From: "Elijah Newren" <newren@gmail.com>
Subject: Which freedesktop.org "design flaws" in git are still relevant?
Date: Fri, 29 Feb 2008 13:32:49 -0700
Message-ID: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 21:33:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVBv8-00059w-Rf
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 21:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbYB2Ucx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 15:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYB2Ucx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 15:32:53 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:51913 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYB2Ucw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 15:32:52 -0500
Received: by ik-out-1112.google.com with SMTP id c28so2476170ika.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 12:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=JxfXY29uSHfMFi1/Rbw6LbmlNFIzdTJESo/Cli7h6BQ=;
        b=ejA+B/fswsRiQjy8dJ5hKjh6Ql8mZJvD9hCirD+EBwV/DzF83+mv8RVob+8n+uGSA/4SWfgAuk3A6IVPOCVSW7tyl3Xd2IvC9f19x0Lr766Px3OJTJFD/ljO8isrHu6h1uhP0eP1hDByCwKOQS8RQIUYO5BwkbSRi1zmTu5MlzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SIBJAy9g8DYms9ffoS7H0MgpeAgPsDmlGQ+OToMCeKSskxsVjxnX2f9Rs7KDOuNLmoJ7gtaCb/Eabf96EPN2fs9ux12Byn5jVzaGS9AUJDiBDlldy+ds8l6BlDJWVPbQvzrNuCYXJKsPqLpzdqufDBt3HvMvbQx14ppJ/5FrGnk=
Received: by 10.115.17.11 with SMTP id u11mr1234220wai.149.1204317169816;
        Fri, 29 Feb 2008 12:32:49 -0800 (PST)
Received: by 10.114.205.19 with HTTP; Fri, 29 Feb 2008 12:32:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75558>

Hi,

The page http://www.freedesktop.org/wiki/Infrastructure/git/UIFlaws
contains a number of claimed UI flaws of git.  I suspect that a number
of them are out-of-date; it doesn't seem to jive with my recent
reading of the documentation.  Could anyone point out which are still
accurate with recent git, and which aren't?

Thanks,
Elijah
