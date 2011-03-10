From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] bash: complete 'git diff ...branc<TAB>'
Date: Thu, 10 Mar 2011 11:30:47 -0800
Message-ID: <7vhbba4vtk.fsf@alter.siamese.dyndns.org>
References: <7vfwrd2wbn.fsf@alter.siamese.dyndns.org>
 <1299780749-12435-1-git-send-email-szeder@ira.uka.de>
 <1299780749-12435-2-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 20:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxlZk-0002xW-E2
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 20:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab1CJTbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 14:31:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1CJTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 14:31:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 269F635A8;
	Thu, 10 Mar 2011 14:32:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=eUwj/z
	C7y3FRE0NVq3g1FiI/P16UQZnNgcApilw/3YgmxJZdEZdZ4R4fan66IHBuhFG96G
	yrFvPZXmFppYw7aPMNe/vxT7Bp99fL8yL/roMMiDTrVvQ6THtx5JI7Z3ztPhixrm
	9b4UfRX6x126W/eNACBeTVlYvadWBdAS5j4lA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MW8NqUNgZSVDqvVNJVIEIhHbNOsw3ICY
	1R6zIYS913yJpr0C5NRCam4nP+ZQrsaAlvRz1eV/owCs/jGVPYCUEngNdRxufIZ5
	AirX2UGW6YiXxmPB7rq9II6ai7nDwndfpX7eU4T3lxgSWVE3LdM3fVaDNjAlNPBB
	LdeR+kV+MaI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA3C035A2;
	Thu, 10 Mar 2011 14:32:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A0DC535A1; Thu, 10 Mar 2011
 14:32:17 -0500 (EST)
In-Reply-To: <1299780749-12435-2-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Thu, 10 Mar 2011 19:12:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F241564-4B4D-11E0-93F4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168847>

Thanks.
