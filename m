From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Escape project names before creating pathinfo URLs
Date: Mon, 21 Apr 2008 23:31:13 -0700
Message-ID: <7vfxte4czy.fsf@gitster.siamese.dyndns.org>
References: <1208725436-25408-1-git-send-email-madduck@madduck.net>
 <1208726618-27477-1-git-send-email-madduck@madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "martin f. krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:32:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoC37-0002VW-Pc
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbYDVGbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754556AbYDVGba
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:31:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44391 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530AbYDVGba (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:31:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CB39D1369;
	Tue, 22 Apr 2008 02:31:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 250E71368; Tue, 22 Apr 2008 02:31:20 -0400 (EDT)
In-Reply-To: <1208726618-27477-1-git-send-email-madduck@madduck.net> (martin
 f. krafft's message of "Sun, 20 Apr 2008 23:23:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80066>

Both patches make sense; will apply to 'maint'.
