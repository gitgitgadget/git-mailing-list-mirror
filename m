From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Sep 2008, #01; Sat, 06)
Date: Sun, 07 Sep 2008 16:35:17 -0700
Message-ID: <7vljy3jzre.fsf@gitster.siamese.dyndns.org>
References: <7vtzcso58c.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809070812350.6003@suse104.zenez.com>
 <7v3akbopzb.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809071139060.6003@suse104.zenez.com>
 <7vd4jfn5hx.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.10.0809071723090.25543@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 01:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcToH-0007TG-T5
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 01:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYIGXf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 19:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbYIGXf0
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 19:35:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbYIGXf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 19:35:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E5A7C5E36D;
	Sun,  7 Sep 2008 19:35:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3F4FD5E36C; Sun,  7 Sep 2008 19:35:19 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.10.0809071723090.25543@suse104.zenez.com> (Boyd
 Lynn Gerber's message of "Sun, 7 Sep 2008 17:25:00 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A401706C-7D35-11DD-A11B-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95193>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Sun, 7 Sep 2008, Junio C Hamano wrote:
> ...
>> I think we already have 6ffaecc (shell: do not play duplicated definition
>> games to shrink the executable, 2008-08-19), which was cherry-picked from
>> 4cfc24a (shell: do not play duplicated definition games to shrink the
>> executable, 2008-08-19) on 'master'.  Do you still have problem building
>> 'maint' on your boxes?
>
> No, maint does build.  I just thought your were going to release
> 1.6.0.2 from master.  I think the next commit for set-linebug-setvbug
> needs to be in it for release.

Thanks for clarifying, so as far as you are concerned, 'maint', which is
the only thing that matters for 1.6.0.2, is in a good shape ;-)
