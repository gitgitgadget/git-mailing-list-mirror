From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] builtin-blame: Reencode commit messages according to
 git-log rules.
Date: Tue, 21 Oct 2008 00:34:05 -0700
Message-ID: <7viqrmz9jm.fsf@gitster.siamese.dyndns.org>
References: <1224537879-13000-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 09:35:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsBmA-0004qA-UC
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 09:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbYJUHeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYJUHeT
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 03:34:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYJUHeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 03:34:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5211972E25;
	Tue, 21 Oct 2008 03:34:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1531572E23; Tue, 21 Oct 2008 03:34:11 -0400 (EDT)
In-Reply-To: <1224537879-13000-1-git-send-email-angavrilov@gmail.com>
 (Alexander Gavrilov's message of "Tue, 21 Oct 2008 01:24:39 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA34EF02-9F42-11DD-A5E8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98764>

I think this makes sense.  We'd want a testcase for the new feature before
applying the patch, though.
