From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2 0/3] Recursion-free unpack_entry and packed_object_info
Date: Mon, 25 Mar 2013 23:37:57 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1303252333200.1372@syhkavp.arg>
References: <87620faky3.fsf@linux-k42r.v.cablecom.net>
 <cover.1364234154.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Stefan Zager <szager@google.com>,
	Jeff King <peff@peff.net>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 26 04:38:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKKiQ-00012J-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 04:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759204Ab3CZDh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 23:37:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9156 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759130Ab3CZDh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 23:37:58 -0400
Received: from xanadu.home ([24.203.65.139]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MK9003AB0R9I000@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 25 Mar 2013 23:37:57 -0400 (EDT)
In-reply-to: <cover.1364234154.git.trast@student.ethz.ch>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219129>

On Mon, 25 Mar 2013, Thomas Rast wrote:

> This is a fixed version of the initial patch, plus a two-patch
> implementation of a recursion-free unpack_entry.  (I narrowly resisted
> using "unrecursify" to describe it.)

Hmmm... the intention is sensible and the patches look sane, however I 
don't have my brain wrapped around this code as I used to, so I might 
be missing something.


Nicolas
