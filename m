From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document that git-log takes --all-match.
Date: Sun, 02 Nov 2008 22:17:09 -0800
Message-ID: <7vd4hdwcyi.fsf@gitster.siamese.dyndns.org>
References: <237967ef0811021028w3aa22411t99b2203a9148bbf6@mail.gmail.com>
 <237967ef0811021032j15f7d9cbudfdf9350bc521cd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Mikael Magnusson" <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 07:19:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwsmY-0002tA-Rx
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 07:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYKCGRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 01:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYKCGRl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 01:17:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYKCGRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 01:17:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36D6877375;
	Mon,  3 Nov 2008 01:17:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3D27D77370; Mon,  3 Nov 2008 01:17:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E14A3DC-A96F-11DD-B245-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99902>

"Mikael Magnusson" <mikachu@gmail.com> writes:

> It's already listed in the bash completion. Feel free to reword.

This is a bad strategy to get your patch accepted except on a rare
occasion when I'm not too lazy nor busy to "feel free".  Besides, the
patch is whitespace damaged.

I fixed it up and queued it nevertheless.  Thanks.
