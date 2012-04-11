From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/8] Highlight interesting parts of diff
Date: Wed, 11 Apr 2012 14:32:48 -0700
Message-ID: <7vk41mhs3j.fsf@alter.siamese.dyndns.org>
References: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 23:33:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5A2-0004vh-66
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 23:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935Ab2DKVcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 17:32:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761324Ab2DKVcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 17:32:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8081D6C09;
	Wed, 11 Apr 2012 17:32:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z39PFn5dW5Nhrrj2YjeNAi8IYAE=; b=qN+6tu
	tS1JKbcum+cYmARdd78msfLNaoAypqd7fBfjzCSv2+qQZDKDxT6dnR18LkXY/Ev7
	MN2q+ADowitQ/03tFKKOgJsvyW+zg/hPbiRTzEVmoalp9jHmbq85vVOAcXNGySf+
	sLTkbuLKEfsTH2Fv8hsFWQBAv1j2oCa3P4FhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMGml0lGXjHLcjxDbfa1wjoOLICQcTM8
	4xsxCTwKLF4yFyedmBM3o6b8RY753dpavIy4XlKqcuoiYxAJ0hPEN4YBSaantdTU
	cSTA2hr7kJkXBg+Y08bH9SG4xVN4lMMOwuc1Naxho92tAk6h+zxJEwd7q6f/OWyE
	h4sCtYJQYro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78A166C08;
	Wed, 11 Apr 2012 17:32:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12ACB6C07; Wed, 11 Apr 2012
 17:32:49 -0400 (EDT)
In-Reply-To: <1334179124-14258-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Wed, 11 Apr 2012
 23:18:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E356EA06-841D-11E1-85BC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195267>

Thanks; will queue.
