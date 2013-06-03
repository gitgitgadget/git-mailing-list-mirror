From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/6] git send-email suppress-cc=self fixes
Date: Mon, 3 Jun 2013 19:36:12 +0300
Message-ID: <20130603163612.GC16841@redhat.com>
References: <1369897638-27299-1-git-send-email-mst@redhat.com>
 <7vy5ari2vj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:35:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjXjW-0000xz-FF
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759203Ab3FCQfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:35:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2058 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758786Ab3FCQfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:35:42 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r53GZffp015174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 3 Jun 2013 12:35:41 -0400
Received: from redhat.com (vpn1-4-128.ams2.redhat.com [10.36.4.128])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r53GZdsq023504;
	Mon, 3 Jun 2013 12:35:40 -0400
Content-Disposition: inline
In-Reply-To: <7vy5ari2vj.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226234>

On Mon, Jun 03, 2013 at 09:18:56AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > This includes bugfixes related to handling of --suppress-cc=self
> > flag. Tests are also included.
> 
> Thanks, will queue.

OK pls let me know if this means you intend to handle the rest of your
comments yourself or if I need to fix anything.
