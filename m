From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: Recent annoying problem with Linus's git repository?
Date: Mon, 12 Jan 2009 09:29:42 +0100
Message-ID: <20090112082942.GC29673@fiberbit.xs4all.nl>
References: <alpine.LNX.2.00.0901111615500.4963@x9.ybpnyarg> <20090112075942.GB29673@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, rmk@arm.linux.org.uk
To: walt <w41ter@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:44:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMIOv-0001ds-5p
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbZALImh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbZALImh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:42:37 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1654 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbZALImh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 03:42:37 -0500
X-Greylist: delayed 769 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Jan 2009 03:42:36 EST
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id n0C8TglG057592
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 12 Jan 2009 09:29:42 +0100 (CET)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1LMIB4-0000gM-92; Mon, 12 Jan 2009 09:29:42 +0100
Content-Disposition: inline
In-Reply-To: <20090112075942.GB29673@fiberbit.xs4all.nl>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105303>

On Monday January 12th 2009 at 08:59 Marco Roeland wrote:

> The file should probably just be really deleted. Adding Russell to the
> Cc. ;-)

Andrew Price already reported the issue and sent a patch last Wednesday:

http://marc.info/?l=linux-kernel&m=123134235028543&w=2
-- 
Marco Roeland, who should check all his mailing lists before answering
