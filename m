From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC Project Proposal - Project Code Graph - Need mentor and
 better name
Date: Thu, 05 Apr 2012 18:00:57 -0700
Message-ID: <7v7gxt4qt2.fsf@alter.siamese.dyndns.org>
References: <CAEGc5Zw_eBhp8Dpc+NPjJ7Mqw_+B0epir1ZR_JOdQRJC2ZGuUA@mail.gmail.com>
 <CAEGc5Zx7-dEwdRKHYJLxiVxTL4HtHWwKSVsfvuFUjUqzn7ZHEQ@mail.gmail.com>
 <CAEGc5Zyf2zh8sKHiFNJeUJbyCqw91MJ-hy51SyCNn+eXaCiT_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Suhail Sherif <suhail.sherif@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 03:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFxY2-00066p-72
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 03:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755Ab2DFBBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 21:01:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56552 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639Ab2DFBBA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 21:01:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A572C6498;
	Thu,  5 Apr 2012 21:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NIM5qDkUYU5PfRTbxy0mpgtzMBU=; b=b4C+Ob
	g+UI2KvqJKiH0CBmJp8JVYT4iupvOPoOlyVnFbtMXOJ5zlhMSbwfiUriWwR/DRw0
	ciJn4qIzvu/a4eliskYkPapthJyMam0telzLSY0LBTZOLKguP6yB2INqwNdORw0d
	EmeC7IjIqPVU9ZTMDoYT1wyvFUtiLmx4VSU40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7nq8jKMpxGpCyyf/oCmC/lcHfr/8z1+
	QBg7sUmVdlramCMWDU6c/GBVpjy3zmJn66EDUgeuXnNvuoZ+Q7huIZL4mHQegtqD
	Vbq8hLAyB25tZtmmP2isqm4BYDnZ5GIUOmnwYOmnWqMwNZ6WNRv/Giy5MFDFf4Gh
	9YUWVGGVomY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C6046497;
	Thu,  5 Apr 2012 21:00:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12E476491; Thu,  5 Apr 2012
 21:00:58 -0400 (EDT)
In-Reply-To: <CAEGc5Zyf2zh8sKHiFNJeUJbyCqw91MJ-hy51SyCNn+eXaCiT_w@mail.gmail.com> (Suhail
 Sherif's message of "Fri, 6 Apr 2012 04:52:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8E2B844-7F83-11E1-AF71-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194830>

Suhail Sherif <suhail.sherif@gmail.com> writes:

> In short, this proposal is aimed at having a better way to view the
> status of a project by having issues, todos and dependencies mapped as
> a graph.
>
> My main motive behind this is that a newcomer to an open source
> project can look at the graph and immediately see where he can pitch
> in. Having to go through tons of issues and changelogs is generally
> not so alluring.
>
> Here is the project proposal in full:
> http://www.google-melange.com/gsoc/proposal/review/google/gsoc2012/suhailsherif/1

Hrm, while the project may be interesting, I personally do not see how
this is related to the Git project...
