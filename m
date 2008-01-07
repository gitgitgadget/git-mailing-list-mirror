From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Mon, 07 Jan 2008 00:27:29 -0800
Message-ID: <7vhchq11n2.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
	<7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
	<7v63y8ble8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Eric Wong <normalperson@yhbt.net>,
	"J. Bruce Fields" <bfields@citi.umich.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 09:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBnLC-0003nj-43
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 09:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbYAGI1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 03:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbYAGI1o
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 03:27:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422AbYAGI1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 03:27:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 394752E65;
	Mon,  7 Jan 2008 03:27:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4238B2E64;
	Mon,  7 Jan 2008 03:27:33 -0500 (EST)
In-Reply-To: <7v63y8ble8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 05 Jan 2008 02:46:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69770>

I've applied all the leftover bits I mentioned in yesterday's
message and 'master' tonight is pretty much where I want it to
be in 1.5.4-rc3 (and in 1.5.4 final).

Subsystem people (except Shawn, whose git-gui 0.9.1 is already
in) are requested to tell me to pull from them, if they have
accumulated changes that should be in the final release.  I am
hoping that I can tag -rc3 in a few days (say by the end of my
Wednesday).
