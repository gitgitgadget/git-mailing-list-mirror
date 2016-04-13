From: Nikola =?ISO-8859-1?Q?Forr=F3?= <nforro@redhat.com>
Subject: Re: [PATCH v2] difftool/mergetool: make the form of yes/no
 questions consistent
Date: Wed, 13 Apr 2016 12:27:35 +0200
Organization: Red Hat
Message-ID: <1460543255.3228.13.camel@redhat.com>
References: <1460472260.3214.23.camel@redhat.com>
	 <xmqqegaapm02.fsf@gitster.mtv.corp.google.com>
Reply-To: nforro@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 12:28:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqI1u-0008Fr-Uk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 12:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030821AbcDMK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 06:27:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44592 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030271AbcDMK1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 06:27:38 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBD2564070;
	Wed, 13 Apr 2016 10:27:37 +0000 (UTC)
Received: from unused-4-132.brq.redhat.com (unused-4-132.brq.redhat.com [10.34.4.132])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u3DARZhQ020429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Apr 2016 06:27:37 -0400
In-Reply-To: <xmqqegaapm02.fsf@gitster.mtv.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 13 Apr 2016 10:27:37 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291385>

On Tue, 2016-04-12 at 14:15 -0700, Junio C Hamano wrote:
> Thanks; have you run the test suite with this patch applied?

Sorry, I totally forgot. I'll make sure to do that next time.

Thanks,
Nikola
