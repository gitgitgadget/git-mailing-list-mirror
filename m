From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] force_object_loose: Fix memory leak
Date: Sat, 18 Oct 2008 11:08:07 -0700
Message-ID: <7v1vyddbeg.fsf@gitster.siamese.dyndns.org>
References: <20081018003731.GA17290@atjola.homenet>
 <alpine.LFD.2.00.0810172105030.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 18 20:09:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrGEy-0002gj-Ff
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 20:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbYJRSIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 14:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbYJRSIQ
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 14:08:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54800 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYJRSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 14:08:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B504671CBF;
	Sat, 18 Oct 2008 14:08:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8617B71CBD; Sat, 18 Oct 2008 14:08:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BB07180A-9D3F-11DD-993F-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98562>

Thanks.
