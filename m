From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in gitweb (20 Sep 2008)
Date: Sat, 20 Sep 2008 21:54:11 -0700
Message-ID: <7vhc8a14lo.fsf@gitster.siamese.dyndns.org>
References: <200809210138.01874.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	"J.H." <warthog19@eaglescrag.net>,
	"Gustavo Sverzut Barbieri" <barbieri@profusion.mobi>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 06:55:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhGyp-0006lL-Gq
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 06:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbYIUEyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbYIUEyV
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 00:54:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbYIUEyV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 00:54:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7248A63A0C;
	Sun, 21 Sep 2008 00:54:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 19B1363A09; Sun, 21 Sep 2008 00:54:12 -0400 (EDT)
In-Reply-To: <200809210138.01874.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 21 Sep 2008 01:38:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5A3B2496-8799-11DD-BEF0-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96383>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio, what about "[PATCH] avoid gitweb uninitialized value warning"
> (http://thread.gmane.org/gmane.comp.version-control.git/95028)? This
> is pure bugfix (well, warning fix, and failrly rare one, but warning
> which goes to web server logs).

Thanks for a summary.  I think I've applied this one a few days ago to
'maint' and merged the result up.
