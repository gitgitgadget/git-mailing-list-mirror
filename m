From: vicentiu.neagoe@ni.com
Subject: search for equivalent commits by patch-id
Date: Thu, 19 Jun 2014 15:26:17 +0300
Message-ID: <53A2D6E9.30341.4A8A1942@vicentiu.neagoe.ni.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 15:25:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxcKw-0001KP-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 15:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbaFSNZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 09:25:00 -0400
Received: from skprod3.natinst.com ([130.164.80.24]:50958 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754863AbaFSNY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 09:24:58 -0400
X-Greylist: delayed 3517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2014 09:24:57 EDT
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-snip2-1338.natinst.com [130.164.19.135])
	by us-aus-skprod3.natinst.com (8.14.5/8.14.5) with ESMTP id s5JCQJTA029243
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 07:26:19 -0500
Received: from [10.113.1.11] ([130.164.14.198])
          by us-aus-mgwout1.amer.corp.natinst.com (Lotus Domino Release 8.5.3FP5)
          with ESMTP id 2014061907261999-192846 ;
          Thu, 19 Jun 2014 07:26:19 -0500 
X-mailer: Pegasus Mail for Windows (4.70)
X-MIMETrack: Itemize by SMTP Server on US-AUS-MGWOut1/AUS/H/NIC(Release 8.5.3FP5|July 31, 2013) at
 06/19/2014 07:26:20 AM,
	Serialize by Router on US-AUS-MGWOut1/AUS/H/NIC(Release 8.5.3FP5|July 31, 2013) at
 06/19/2014 07:26:20 AM,
	Serialize complete at 06/19/2014 07:26:20 AM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.12.52,1.0.14,0.0.0000
 definitions=2014-06-19_04:2014-06-19,2014-06-19,1970-01-01 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252113>

Hello,

Is there a way to find all equivalent commits by patch-id?

Something similar to:

git branch -a --commit <commit>

but instead of <commit> to search by patch-id.

thanks

Vicentiu
