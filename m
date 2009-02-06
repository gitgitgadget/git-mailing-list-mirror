From: Miles Bader <miles@gnu.org>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 06 Feb 2009 14:12:03 +0900
Message-ID: <buobptg6tek.fsf@dhlpc061.dev.necel.com>
References: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
	<Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: gyles19@visi.com
X-From: git-owner@vger.kernel.org Fri Feb 06 06:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVJ2v-0005ad-7j
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 06:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbZBFFMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 00:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbZBFFMR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 00:12:17 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:33421 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZBFFMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 00:12:16 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n165BgJM009030;
	Fri, 6 Feb 2009 14:12:04 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay11.aps.necel.com with ESMTP; Fri, 6 Feb 2009 14:12:04 +0900
Received: from dhlpc061 ([10.114.112.240] [10.114.112.240]) by relay11.aps.necel.com with ESMTP; Fri, 6 Feb 2009 14:12:04 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id F412C52E27C; Fri,  6 Feb 2009 14:12:03 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
	(Joi Ellis's message of "Thu, 5 Feb 2009 22:45:13 -0600 (CST)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108654>

Joi Ellis <gyles19@visi.com> writes:
> Because there is no configure script provided, and because my autoconf
> is considered too old, I simply can't start the build process because
> I can't generate the missing configure script.

Er, why don't you upgrade to a less ancient version of autoconf...?

Autoconf 2.59 (which is what it seems to want) was released like 5 years ago!

-Miles

-- 
97% of everything is grunge
