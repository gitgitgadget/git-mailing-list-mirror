From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2010" - features used,
 features wanted
Date: Sun, 15 Aug 2010 18:54:47 -0700
Message-ID: <7v62zbfhjs.fsf@alter.siamese.dyndns.org>
References: <201008152357.29889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Okoui-0006Jq-Ef
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab0HPByy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Aug 2010 21:54:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0HPByy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Aug 2010 21:54:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E1225CD94F;
	Sun, 15 Aug 2010 21:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sd8ggWsQh6pni74/MzgSugSut/Q=; b=h1zci1
	+FOfF8Kyy1Vg4wGeRBqzpzG6lGLg9y/inZzDKGTShbd0hejKGZj58ajZUhhYRTEF
	pO3JbB3fS9JjjuRaqWOfICm5CTq06QV4znG+gpo1DJRS6qjc5xPT/5wq6JN7njbb
	LXoN30riGCpssDZ7aKxsGtLYjyd1n8DqTOYIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6K/IovXcwVbEdUq6ZVl1RpXj4HrsBZW
	RshEy6wCXMuzTsW4o56AfscwzcRdKajexa5+GKtaCXXu8zvdakoBEKNTv9bXjwxX
	kHUC+wCXykQs+iL5P4QcNf3rVC+u1sILqjM47udZYh1hQPFlqjTrYjehoL98rNyw
	dpHifAv2SxQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B96F4CD94D;
	Sun, 15 Aug 2010 21:54:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19A9BCD948; Sun, 15 Aug
 2010 21:54:48 -0400 (EDT)
In-Reply-To: <201008152357.29889.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun\, 15 Aug 2010 23\:57\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 42405380-A8D9-11DF-A872-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153644>

Jakub Narebski <jnareb@gmail.com> writes:

>  + environmental variables in config, expanding ~ and ~user

Micronit.  They are "environment variable", never "environmental".
