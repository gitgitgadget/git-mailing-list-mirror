From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] tests: modernise style: more uses of test_line_count
Date: Wed, 11 Apr 2012 19:35:46 +0200
Message-ID: <4F85C0F2.4060500@gmail.com>
References: <e701486509c3306420e6bcf82e7d0d79fb2e7ae1.1334143281.git.stefano.lattarini@gmail.com> <7vy5q2ky7d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:36:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1Sa-000862-NY
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759472Ab2DKRfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:35:55 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44564 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759447Ab2DKRfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:35:54 -0400
Received: by bkcik5 with SMTP id ik5so881055bkc.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 10:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=RTar3bK5621Vr8TBEVTbKHWCoMcw6Em9VBqKYw5h+Pc=;
        b=m097B9s7LL2SEw79UwWiz7/7ybD8jURM1WwHNQ8tEmFLVir5pkM0cqQUlE0R5EwGpu
         hZ5agc+2lCFZqGVpF9vw1VW+aYksbMcO2IctK4s0m54YnKKOkfL2ObSCi9aEWkHghEs8
         dfdyykKrL6Iq3zagDQ0B69B5H/6yyfRsUTYurDP7GJmQAmEMNxr7URFehVBm2s5n9wym
         jfWCrJat2vn7N4EfeZpmPIydH+NrapZOFS7skWFWrKcWBp9ko7+w33pePmGZ1b3G176H
         Z6Q4dfw///UMUkmuK1LeXrWw9OydKiV/dxU4SAhA9paZatl3seCVntXrcPlJ6H3/+BOv
         CUOw==
Received: by 10.204.13.72 with SMTP id b8mr6196027bka.105.1334165753647;
        Wed, 11 Apr 2012 10:35:53 -0700 (PDT)
Received: from [82.60.30.201] (host201-30-dynamic.60-82-r.retail.telecomitalia.it. [82.60.30.201])
        by mx.google.com with ESMTPS id s16sm6219538bkt.3.2012.04.11.10.35.50
        (version=SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 10:35:52 -0700 (PDT)
In-Reply-To: <7vy5q2ky7d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195223>

On 04/11/2012 06:52 PM, Junio C Hamano wrote:
> I'll squash this in, but otherwise it looks good.  There is nothing
> conflicting in flight right now.
> 
Thanks for taking care of that, and sorry for the sloppiness.

Regards,
  Stefano
