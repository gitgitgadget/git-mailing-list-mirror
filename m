From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: More on git over HTTP POST
Date: Sun, 03 Aug 2008 04:29:38 -0700
Message-ID: <489596A2.9030704@zytor.com>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <20080803025602.GB27465@spearce.org> <7v63qiydzg.fsf@gitster.siamese.dyndns.org> <48952A62.6050709@zytor.com> <20080803041014.GD27465@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 03 13:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPbpl-0002G1-NP
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 13:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbYHCL32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 07:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbYHCL32
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 07:29:28 -0400
Received: from terminus.zytor.com ([198.137.202.10]:55584 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbYHCL31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 07:29:27 -0400
Received: from [10.71.1.72] ([12.197.88.10])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m73BTKJC022087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 04:29:21 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080803041014.GD27465@spearce.org>
X-Virus-Scanned: ClamAV 0.93.3/7920/Sun Aug  3 01:44:32 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91228>

Shawn O. Pearce wrote:
> 
> IOW I had thought we were past this dark age of the Internet.
> 

If we were, there wouldn't be a need for this project at all.  The whole 
purpose of it is to deal with corporate proxies that try to prevent 
actual communication because of "security", and it's really hard to 
predict what utterly arbitrary heuristics they have applied.

	-hpa
