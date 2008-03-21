From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path"
 config var
Date: Fri, 21 Mar 2008 02:00:14 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803210100.m2L10Emt031103@localhost.localdomain>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <7vabkv7t4c.fsf@gitster.siamese.dyndns.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: chriscool@tuxfamily.org, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcWC7-00082d-98
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 02:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYCUBgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 21:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYCUBgg
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 21:36:36 -0400
Received: from master.uucpssh.org ([193.218.105.66]:56024 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbYCUBgf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 21:36:35 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 2B85DD555B; Fri, 21 Mar 2008 02:35:28 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2L10N05031293;
	Fri, 21 Mar 2008 02:00:23 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2L10Emt031103;
	Fri, 21 Mar 2008 02:00:14 +0100
In-reply-to: <7vabkv7t4c.fsf@gitster.siamese.dyndns.org> (message from Junio C
	Hamano on Tue, 18 Mar 2008 12:02:43 -0700)
User-Agent: Rmail in GNU Emacs 23.0.60.3 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.382,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.02,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77693>


   As a general rule, if you allow the user to explicitly say "instead of
   what you would normally use, use _this_", you should not try to outsmart
   the user by using something else that you derived from that "_this_" the
   user gave you.

I second that.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org
