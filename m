From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATHv2 6/8] gitweb: retrieve snapshot format from PATH_INFO
Date: Tue, 21 Oct 2008 12:09:14 -0700
Message-ID: <7vtzb5ydd1.fsf@gitster.siamese.dyndns.org>
References: <1224188831-17767-6-git-send-email-giuseppe.bilotta@gmail.com>
 <1224426270-27755-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200810211844.35714.jnareb@gmail.com>
 <cb7bb73a0810211136n452ac8bdp7814ff09749b3142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 21:10:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsMcw-00021S-8p
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbYJUTJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbYJUTJd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:09:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYJUTJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:09:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CFD9725F5;
	Tue, 21 Oct 2008 15:09:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D105D725EC; Tue, 21 Oct 2008 15:09:22 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CAB62D02-9FA3-11DD-B94A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98805>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

>> But I'd rather have this patch series to be in separate thread...
>
> Yes, a posteriori I think it's better too. I'll resend the 5 path_info
> patches with the minor stylistic corrections you suggested, and send
> these 3 separately.

I've only been watching from the sidelines, but the discussion seemed
sensible.  With the resend with Acks I think they are already 'next'
material.

Thanks, both of you.  
