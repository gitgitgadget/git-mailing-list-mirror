From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add --no-edit to git-commit
Date: Sun, 16 Sep 2012 22:05:10 -0700
Message-ID: <7v7grtxmrd.fsf@alter.siamese.dyndns.org>
References: <5055F8F3.7050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yacine Belkadi <yacine.belkadi.1@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:05:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTWN-0003TE-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab2IQFFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:05:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2IQFFM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:05:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 274649B61;
	Mon, 17 Sep 2012 01:05:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bm22Sfyt3icUZgjlfGT3jTtAOUM=; b=HhaJH6
	X/VVTbYnwpxqXMzhGP2NxfcVYWO5zjlUtMugKhqemafN+7QC8U++BPMxi5v1hhli
	f4y8eA6tnaQqssbWBWZexGuXjWjXlJgMRsxu+5ODGoniAFeXymNLr9PS5y6x3AVP
	gdp9l3YogM9vMlcyLqGq0IsZ6z53tRLJaV9Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SmbU6aJsy1nKhGmuKZFcFPgADXUXHUqu
	nx3iubNLk5DdBHodkLPGeOis717IKel+ke+qCchx2t8HxZemAE+hHWEzOeJz6rmH
	ZNsV0XjdFFZMZqJyJLugaUgyU7sGSFlz8GiwFaa4MM3/76RbXXcgvX77v2XcOexd
	NB9QJpVikHs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138C49B60;
	Mon, 17 Sep 2012 01:05:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8554E9B5F; Mon, 17 Sep 2012
 01:05:11 -0400 (EDT)
In-Reply-To: <5055F8F3.7050705@gmail.com> (Yacine Belkadi's message of "Sun,
 16 Sep 2012 18:06:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 422E9DC4-0085-11E2-90B7-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205644>

thanks.
