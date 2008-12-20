From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: make tagger information optional
Date: Fri, 19 Dec 2008 16:59:39 -0800
Message-ID: <20081220005939.GV32487@spearce.org>
References: <20081218164614.GS5691@genesis.frugalware.org> <7vbpv9guqd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302> <20081218213407.GX5691@genesis.frugalware.org> <7viqphf4ua.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0812200059480.30769@pacific.mpi-cbg.de> <7vfxkj65y5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	scott@canonical.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 02:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDqDx-0004Wh-3b
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 02:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYLTA7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 19:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYLTA7k
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:59:40 -0500
Received: from george.spearce.org ([209.20.77.23]:55983 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbYLTA7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 19:59:40 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9D2D838200; Sat, 20 Dec 2008 00:59:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vfxkj65y5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103616>

Junio C Hamano <gitster@pobox.com> wrote:
> Even though newer Porcelain tools always record the tagger information
> when creating new tags, export/import pair should be able to faithfully
> reproduce ancient tag objects that lack tagger information.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks Junio.

Acked-by: Shawn O. Pearce <spearce@spearce.org>


-- 
Shawn.
