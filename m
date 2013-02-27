From: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
Subject: how to check pending commits to be pushed?
Date: Wed, 27 Feb 2013 15:02:38 -0700
Message-ID: <C89CA603-2D94-44DB-8576-A296BAB5DA53@linea.gov.br>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 23:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UApdZ-0001A0-7T
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 23:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848Ab3B0Who (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 17:37:44 -0500
Received: from mailout04.yourhostingaccount.com ([65.254.253.34]:40860 "EHLO
	mailout04.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433Ab3B0Whn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 17:37:43 -0500
X-Greylist: delayed 2098 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Feb 2013 17:37:43 EST
Received: from mailscan16.yourhostingaccount.com ([10.1.15.16] helo=mailscan16.yourhostingaccount.com)
	by mailout04.yourhostingaccount.com with esmtp (Exim)
	id 1UAp5H-0001iW-26
	for git@vger.kernel.org; Wed, 27 Feb 2013 17:02:43 -0500
Received: from impout01.yourhostingaccount.com ([10.1.55.1] helo=impout01.yourhostingaccount.com)
	by mailscan16.yourhostingaccount.com with esmtp (Exim)
	id 1UAp5G-00088y-UX; Wed, 27 Feb 2013 17:02:42 -0500
Received: from authsmtp11.yourhostingaccount.com ([10.1.18.11])
	by impout01.yourhostingaccount.com with NO UCE
	id 5a2i1l00S0EKrUA01a2iVo; Wed, 27 Feb 2013 17:02:42 -0500
X-Authority-Analysis: v=2.0 cv=EJGEIilC c=1 sm=1
 a=9tqLmMrRgdOymYn0M24ASw==:17 a=Qa21fcannPsA:10 a=gtHvTDQHU3cA:10
 a=kj9zAlcOel0A:10 a=giT5yijdotUA:10 a=woKh0Bqjk8RX19jOrVMA:9
 a=CjuIK1q_8ugA:10 a=5bnIr+R+vs56oWgm0tidcA==:117
X-EN-OrigOutIP: 10.1.18.11
X-EN-IMPSID: 5a2i1l00S0EKrUA01a2iVo
Received: from [153.90.102.166]
	by authsmtp11.yourhostingaccount.com with esmtpa (Exim)
	id 1UAp5G-00086Q-Iy; Wed, 27 Feb 2013 17:02:42 -0500
X-Mailer: Apple Mail (2.1485)
X-EN-UserInfo: 957f87d35c43172285e6793414996149:be26a490d08ddddd1ae22626b86f1c91
X-EN-AuthUser: patricia@egeland.us
X-EN-OrigIP: 153.90.102.166
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217225>

Hi,

      Does someone know how to identify pending commits to be pushed in a local super repository (with quite some submodules), with git-1.6.5-1 ?

Thanks,
Patricia