Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=5.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_SIGNED,FSL_BULK_SIG,HEADER_FROM_DIFFERENT_DOMAINS,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBEBD20179
	for <e@80x24.org>; Thu, 16 Jun 2016 23:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752815AbcFPXb3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 19:31:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50981 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751711AbcFPXb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 19:31:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 865D026217;
	Thu, 16 Jun 2016 19:31:27 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=XV6HdW
	RlKRhJS9f/hbncAMhp2iO3F611NAYN5663C5MG2iVbYUBFMi1nuS15OeG68qml5j
	P6rEUwiTxrRvcGT2LJv6MpG8SN/gWK6gxrbFuSrT0ROaWANkImWvHYPc3vZz/X9M
	oTKyvJ3C6sGoBo/rtuZRZ2oMtzh9SWsu68ySA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=siIgJUr0slAjUjC2AYv0deFv1qcymGnp
	J0cbQ1gVRXWe+Oy2GEjEaMBqpUK97lo3Y0D2Wz7dgKjKpNV5DqWaO4Y6gw3rlei7
	ma2/fy83DpceyxfKqvHPvta3nZuh0UbMq17gU/gZbqQyoKklrP2YYWmyBDnK1wP0
	EWr2wvR94hM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F1C626216;
	Thu, 16 Jun 2016 19:31:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FAA726215;
	Thu, 16 Jun 2016 19:31:26 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Dave Nicolson <david.nicolson@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: GPG capitalization
References: <01020154fd9dec3d-61772857-8b92-4505-ac0f-5058d490f7dc-000000@eu-west-1.amazonses.com>
	<010201555b48c824-324d848d-838a-4908-bf88-bc2ee290da76-000000@eu-west-1.amazonses.com>
Date:	Thu, 16 Jun 2016 16:31:25 -0700
In-Reply-To: <010201555b48c824-324d848d-838a-4908-bf88-bc2ee290da76-000000@eu-west-1.amazonses.com>
	(Dave Nicolson's message of "Thu, 16 Jun 2016 22:15:44 +0000")
Message-ID: <xmqqtwgs3e42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 722D25E6-341A-11E6-AA63-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thanks.
