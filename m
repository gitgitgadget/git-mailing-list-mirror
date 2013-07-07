From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] gitweb: allow extra breadcrumbs to prefix the trail
Date: Sat, 6 Jul 2013 18:05:50 -0700
Message-ID: <20130707010550.GK30132@google.com>
References: <E1Uu3IT-0008U1-3c@hermes-2.csi.cam.ac.uk>
 <E1UunDD-0004Xd-Vv@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sun Jul 07 03:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvdQd-00064T-EK
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 03:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab3GGBFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 21:05:55 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:55306 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab3GGBFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 21:05:54 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3139924pbb.8
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 18:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=3WBeoYhjn+1zLti4z9ZXN8dq5MFngtm/EDFIz518sVo=;
        b=cnV0lv6UhipjXsTWWAL+Dne2z6Xi959lvaN3gB8wsrQAkbrLK8Y/np3Io7V3n2bXeS
         4/u1WMw2Cik6+46tw73aotK551bIcxuCNpTzHho3SjdUW6U4ZTLAXumgSYtdwZ1rvhSo
         jykSwN7E791UHpFG8n8lixUt5lME2zrV2tyrg2XESh0Xj9Q6aLTnXjf3ElQ07dmq6c1+
         zFihmjNTdzuvkU0uLFULQ7ZzOBxVDULrXCc+bTkXhbzGeD2sk6tcwGWwRbkJDZjU2V7+
         aQ5zCmCj17zrvBcMyujTNktPmLf4fYKYIUcMgLsUcJ1KeSzDgYa3lNQL9vADCudAmYy5
         InkQ==
X-Received: by 10.66.222.1 with SMTP id qi1mr16564587pac.53.1373159153950;
        Sat, 06 Jul 2013 18:05:53 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id eg3sm15786462pac.1.2013.07.06.18.05.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 18:05:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1UunDD-0004Xd-Vv@hermes-2.csi.cam.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229712>

Tony Finch wrote:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep, fwiw this version looks perfect to me. :)

Thanks.
