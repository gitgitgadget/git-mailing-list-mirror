From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 10 Feb 2008 14:09:39 -0800
Message-ID: <7vwspcea58.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	<7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
	<m3wspcg4hg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:10:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKNq-0005cg-34
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292AbYBJWJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbYBJWJz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:09:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbYBJWJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:09:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 96C382277;
	Sun, 10 Feb 2008 17:09:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1FA32272;
	Sun, 10 Feb 2008 17:09:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73424>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * br/gitweb (Fri Feb 8 14:38:04 2008 -0200) 1 commit
>>  - gitweb: Use the config file to set repository owner's name.
>> 
>> Looked Ok.
>
> I assume that you have squashed commits: chaning gitweb.perl and
> adding to gitweb/README?
>
> I'd rather hear from Pasky first, but well...

Thanks; will keep it on 'pu' for now.
