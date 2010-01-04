From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
	working directory in git gui and gitk
Date: Mon, 4 Jan 2010 14:27:01 -0800
Message-ID: <20100104222701.GE22872@spearce.org>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 04 23:27:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRvOM-0002aQ-CL
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 23:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025Ab0ADW1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 17:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753280Ab0ADW1I
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 17:27:08 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:60099 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab0ADW1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 17:27:07 -0500
Received: by yxe26 with SMTP id 26so15018630yxe.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 14:27:04 -0800 (PST)
Received: by 10.150.120.8 with SMTP id s8mr7193024ybc.185.1262644024321;
        Mon, 04 Jan 2010 14:27:04 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm6403732ywh.3.2010.01.04.14.27.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 04 Jan 2010 14:27:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136145>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Besides, as long as there is enough reason to have out-of-Git alternative 
> solutions such as repo, submodules deserve to be 2nd-class citizens.

If I didn't think I'd be shot by current submodule users, I'd offer
to write a full replacement based around the current in repository
format, but with sane features like we have in repo.

Actually, that's why repo happened.  I felt like submodules was
already too frozen to accept a different approach.  And another
guy here thought XML might be a solution to a problem...  :-|

-- 
Shawn.
