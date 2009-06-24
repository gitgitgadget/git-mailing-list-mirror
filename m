From: Ryan <ryanphilips19@googlemail.com>
Subject: names using git config
Date: Wed, 24 Jun 2009 22:28:40 +0530
Message-ID: <376636be0906240958l70c81b68g83340556f2bf4eca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 18:58:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJVo9-0005ob-JG
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 18:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294AbZFXQ6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753370AbZFXQ6i
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 12:58:38 -0400
Received: from mail-qy0-f193.google.com ([209.85.221.193]:41486 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZFXQ6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 12:58:38 -0400
Received: by qyk31 with SMTP id 31so1169883qyk.33
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=vYBBPoiIzLA2R2Grp/KGIqVrge8mmW1t8nPIG8ovYps=;
        b=u0Ta6u0OrPyRfoMM94Y+2OVht2dDj06d1p56HMPrnBgby/yy5RUVRr78VNXmHAhGpr
         /bKu3RGj0nFk3JbuUhIH8JR2u5ncqOmab2XIZRhtA7t64VUGvg/vMmi9/QKHxCo6YcV4
         R5+48iwtkhNfW6jhK4v0lADYZnz1ICnNv6y3U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ZvetOR6gHJVJGew/yf51vllPTZ63vknHTjAvMCBK4beQf8cJgv4sYP4DvoJJXuf9z2
         lEW7Bsi3CAyUHQwWay1apaZS28Ys1976UDYqWS8cjDUgg+mhYiVMCjJz79G8tMkXC10V
         VEdPx83bLqpA94IMajFol9+Oh8bwVu7hNLW80=
Received: by 10.231.10.134 with SMTP id p6mr499893ibp.36.1245862720345; Wed, 
	24 Jun 2009 09:58:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122145>

How do i select a Name which ends in a dot something like Ryan W.
Philips in Git using  git config user.name

Because when i do that "Ryan W. Philips" It just comes and Ryan W
Philips in git log when i add a commit.


Thanks,
Ryan
