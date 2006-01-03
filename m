From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: how to find outstanding patches in non-linux-2.6 repositories ?
Date: Tue, 3 Jan 2006 20:21:03 +0100
Message-ID: <20060103192103.GA15002@fiberbit.xs4all.nl>
References: <Pine.LNX.4.63.0601012228470.32311@wbgn013.biozentrum.uni-wuerzburg.de> <1136315518.11946.28.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:21:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtriZ-0003Kn-MA
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 20:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWACTVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 14:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWACTVI
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 14:21:08 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:27330 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751469AbWACTVH
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 14:21:07 -0500
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1EtriR-0003uk-Fm; Tue, 03 Jan 2006 20:21:03 +0100
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1136315518.11946.28.camel@cashmere.sps.mot.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14156>

On Tuesday January 3rd 2006 Jon Loeliger wrote:

> Could someone remind me where the <ref>..<ref> syntax
> is documented, please?  I went digging, but I am lame
> and couldn't find it.

It is in the documentation for git-rev-list:

In the "Description" section for git-rev-list:

A special notation <commit1>..<commit2> can be used as a short-hand for
^<commit1> <commit2>.
-- 
Marco Roeland
