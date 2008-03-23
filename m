From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fast-import: Document the effect of "merge" with no
 "from" in a commit
Date: Sat, 22 Mar 2008 23:17:47 -0700
Message-ID: <7v3aqiezg4.fsf@gitster.siamese.dyndns.org>
References: <F6F70627-FAE7-43F1-BECC-E70A4A561982@orakel.ntnu.no>
 <20080318034321.GK8410@spearce.org>
 <F4486D8E-3256-4FA7-89A7-3EC7E7D64162@orakel.ntnu.no>
 <20080319020625.GA3535@spearce.org>
 <9A41E5AD-2305-457B-A214-7A11A1B559F6@orakel.ntnu.no>
 <20080320034031.GX8410@spearce.org>
 <6FC571BB-D304-4D25-B1F2-1E03BD5438F8@orakel.ntnu.no>
 <FB8C4A1F-3DC1-4D7B-910B-5F721F39B244@orakel.ntnu.no>
 <BDCF3EE6-0813-40B1-96D8-CCBADCCDAEA6@orakel.ntnu.no>
 <20080323050028.GI8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>,
	James Westby <jw+debian@jameswestby.net>,
	Ian Clatworthy <ian.clatworthy@internode.on.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 07:18:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdJXg-0002sn-H5
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 07:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbYCWGSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 02:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbYCWGSL
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 02:18:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbYCWGSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 02:18:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 362611304;
	Sun, 23 Mar 2008 02:18:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 783F51303; Sun, 23 Mar 2008 02:17:59 -0400 (EDT)
In-Reply-To: <20080323050028.GI8410@spearce.org> (Shawn O. Pearce's message
 of "Sun, 23 Mar 2008 01:00:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77869>

Thanks, both.
