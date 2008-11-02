From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATHv2 8/8] gitweb: make the supported snapshot formats array
 global
Date: Sun, 02 Nov 2008 01:50:22 -0700
Message-ID: <7vbpwy1pgx.fsf@gitster.siamese.dyndns.org>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-3-git-send-email-giuseppe.bilotta@gmail.com>
 <200811020255.01895.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 09:51:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwYgb-0005Qm-WF
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 09:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbYKBIuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 03:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752813AbYKBIuj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 03:50:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805AbYKBIui (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 03:50:38 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 49F3077959;
	Sun,  2 Nov 2008 03:50:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D3F1B77943; Sun,  2 Nov 2008 03:50:29 -0500 (EST)
In-Reply-To: <200811020255.01895.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 2 Nov 2008 02:54:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51A207B2-A8BB-11DD-B879-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99822>

Jakub Narebski <jnareb@gmail.com> writes:

> Very good idea, although I'd prefer for this patch to come first;
> it is not controversial contrary to other patches in this (sub)series
> which IMHO needs some thought first.
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>

I've dismissed the three patches 6-8 (without prejudice, as I lost track
of them); please resubmit and re-ack.
