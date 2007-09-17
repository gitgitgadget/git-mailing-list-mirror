From: Junio C Hamano <gitster@pobox.com>
Subject: Re: metastore
Date: Mon, 17 Sep 2007 12:19:14 -0700
Message-ID: <7v3axd14nh.fsf@gitster.siamese.dyndns.org>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151507310.28586@racer.site>
	<20070915145437.GA12875@piper.oerlikon.madduck.net>
	<Pine.LNX.4.64.0709151430040.5298@iabervon.org>
	<Pine.LNX.4.64.0709152310380.28586@racer.site>
	<Pine.LNX.4.64.0709151737400.24221@asgard.lang.hm>
	<7vwsur590q.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161245490.24221@asgard.lang.hm>
	<7v7imq5ki0.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161541330.24221@asgard.lang.hm>
	<7vk5qq3y76.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709161925000.24221@asgard.lang.hm>
	<7v7imp539u.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0709171308150.5298@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?Q?H=C3=A4rdeman?= <david@hardeman.nu>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 21:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXM85-0001Jt-SV
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 21:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbXIQTT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 15:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754806AbXIQTT1
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 15:19:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:39605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731AbXIQTT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 15:19:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BBB36136D6D;
	Mon, 17 Sep 2007 15:19:37 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709171308150.5298@iabervon.org> (Daniel
	Barkalow's message of "Mon, 17 Sep 2007 13:42:06 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58471>

Daniel Barkalow <barkalow@iabervon.org> writes:

> .... Things can be a lot more 
> acceptable if the intrusive changes are improvements for the 
> maintainability of the normal case, and the special case code is no longer 
> intrusive at all.

Very well said.
