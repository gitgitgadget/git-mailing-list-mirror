From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2008, #05; Wed, 22)
Date: Fri, 24 Oct 2008 15:13:17 -0700
Message-ID: <7vprlp1w1u.fsf@gitster.siamese.dyndns.org>
References: <7v8wsf50ne.fsf@gitster.siamese.dyndns.org>
 <gdsjb1$eob$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:14:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUvb-0001lQ-QC
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758056AbYJXWNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYJXWN3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:13:29 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050AbYJXWN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:13:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E41B58F1F3;
	Fri, 24 Oct 2008 18:13:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B82C58F1F2; Fri, 24 Oct 2008 18:13:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB40E850-A218-11DD-81F2-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99073>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> * gb/gitweb-pathinfo (Tue Oct 21 21:34:54 2008 +0200) 5 commits
>>  - gitweb: generate parent..current URLs
>>  - gitweb: parse parent..current syntax from PATH_INFO
>>  - gitweb: use_pathinfo filenames start with /
>>  - gitweb: generate project/action/hash URLs
>>  - gitweb: parse project/action/hash_base:filename PATH_INFO
>> 
>> Seventh iteration; hopefully the usual gitweb gangs will give quick
>> comments and ack to push this out to 'next' soon.
>
> If I remember correctly v7 is mainly cosmetic changes, and I have
> acked all or almost all of the equivalent patches from v6.

I take it to mean you reviewed v7 and we have your Ack on them;
thanks.
