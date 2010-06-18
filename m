From: Gavin Kistner <gkistner@nvidia.com>
Subject: RE: unpacker error on push
Date: Fri, 18 Jun 2010 10:55:58 -0700
Message-ID: <01804B6F1D74DE41819D69F2866C60EF2AB4D55F47@HQMAIL03.nvidia.com>
References: <0B32FF97-4B20-4B9A-BA45-08EF9485F3A1@nvidia.com>
 <alpine.LFD.2.00.1006161520480.13427@xanadu.home>
 <64131565-2407-4EBF-A6CB-7C286E1B20D4@nvidia.com>
 <alpine.LFD.2.00.1006181332230.13427@xanadu.home>
 <26F05D1B-E6A7-4039-B337-DA5C027A4EE5@nvidia.com>
 <alpine.LFD.2.00.1006181352150.13427@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: 'Nicolas Pitre' <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Jun 18 19:56:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPfnU-0001nk-9e
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 19:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761342Ab0FRR4B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 13:56:01 -0400
Received: from hqemgate04.nvidia.com ([216.228.121.35]:18538 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961Ab0FRR4A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 13:56:00 -0400
Received: from hqnvupgp04.nvidia.com (Not Verified[172.20.161.48]) by hqemgate04.nvidia.com
	id <B4c1bb29a0001>; Fri, 18 Jun 2010 10:53:30 -0700
Received: from hqemhub03.nvidia.com ([172.17.108.22])
  by hqnvupgp04.nvidia.com (PGP Universal service);
  Fri, 18 Jun 2010 10:55:59 -0700
X-PGP-Universal: processed;
	by hqnvupgp04.nvidia.com on Fri, 18 Jun 2010 10:55:59 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.12]) by hqemhub03.nvidia.com
 ([172.20.150.15]) with mapi; Fri, 18 Jun 2010 10:55:59 -0700
Thread-Topic: unpacker error on push
Thread-Index: AcsPD15/Xl3jy5n8Q6W02BPkgbATOwAAAVlQ
In-Reply-To: <alpine.LFD.2.00.1006181352150.13427@xanadu.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149356>

No problem; like I said, the ssh-based solution seems to be working for now, so I'm unblocked in my workflow. Diving deeper on this issue is largely interesting to improve git.

-----Original Message-----
From: Nicolas Pitre [mailto:nico@fluxnic.net] 
Sent: Friday, June 18, 2010 11:55 AM
To: Gavin Kistner
Cc: git@vger.kernel.org
Subject: Re: unpacker error on push

On Fri, 18 Jun 2010, Gavin Kistner wrote:

> On Jun 18, 2010, at 11:35 AM, Nicolas Pitre wrote:
> > On Fri, 18 Jun 2010, Gavin Kistner wrote:
> >> If anyone wants to dive deeper into this problem, please let me know 
> >> and we can fight it using the snapshots I have. 
> > 
> > I would be interested in them.
> 
> OK, I'll coordinate with you off-list.

I got them now.  Weekend is coming soon so I might not have time to look 
at it right away though.


Nicolas
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
