From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Add Git-aware CGI for Git-aware smart HTTP transport
Date: Tue, 12 Aug 2008 18:56:38 -0700
Message-ID: <48A23F56.7000607@zytor.com>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com> <20080805012459.GC32543@spearce.org> <4897AE53.4030107@zytor.com> <20080805015717.GB383@spearce.org> <4897B4A5.4030700@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 03:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT5ca-0005Mw-W7
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 03:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbYHMB4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 21:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbYHMB4z
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 21:56:55 -0400
Received: from terminus.zytor.com ([198.137.202.10]:36808 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbYHMB4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 21:56:54 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7D1ueC3027605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Aug 2008 18:56:40 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7D1ueXu001641;
	Tue, 12 Aug 2008 18:56:40 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7D1ucMd014153;
	Tue, 12 Aug 2008 18:56:38 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <4897B4A5.4030700@zytor.com>
X-Virus-Scanned: ClamAV 0.93.3/8021/Tue Aug 12 12:27:39 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92164>

Anything we can do to keep this moving forward?  I was extremely 
encouraged with the fast progress on this; this would be great to get to 
the point where we (kernel.org) can deploy it at least for testing.

	-hpa
