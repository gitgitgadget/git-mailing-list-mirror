From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Document conding style
Date: Wed, 27 Feb 2008 19:36:28 +1100
Message-ID: <ee77f5c20802270036o7e792feqd110b7ea96a3b75c@mail.gmail.com>
References: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Martin Koegler" <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Wed Feb 27 09:37:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUHmp-0003EI-GZ
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 09:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbYB0Igd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 03:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756150AbYB0Igd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 03:36:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.231]:7140 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718AbYB0Igc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 03:36:32 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3964285wra.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=m/9BPAeVceyN5AuWPOSAlWpL3c2LAtxW+8zD0hftsOw=;
        b=Zj9y1KNiF/uEWXa2gRfmLm0UIKsHu5PoF5Q4b3x0tPibTauRuNpGuMm9iHocqYc7zN/etcn2jJQv/uiw7opL5nfmygDPRY6hr1TQ3hdziNmIK1VGk+CWFsjXgApNe5gHCjVeTb3/BX2ERS2mPJzZG4x7eID61JFnwWFXqrGs+CQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mx6bS7RQE2/PuHtdu0J+9ito7hegOpyrWx0QeCLrI6iD9+Jst2qdl7Oq4qTQhU0+vZ647cMltMO/ARd0vbfyt1AYZjfgNaLb4mT8sFVrUnY9qDMm0TKFuE4FZj5bwMH8ihoWkxQo9hikF6B6McoXCqcJPj5JObWDdc3UV4Z5P84=
Received: by 10.141.193.1 with SMTP id v1mr4244697rvp.245.1204101388975;
        Wed, 27 Feb 2008 00:36:28 -0800 (PST)
Received: by 10.140.252.17 with HTTP; Wed, 27 Feb 2008 00:36:28 -0800 (PST)
In-Reply-To: <12041000101604-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75213>

On Wed, Feb 27, 2008 at 7:13 PM, Martin Koegler
<mkoegler@auto.tuwien.ac.at> wrote:
>  + - Consider checking your patches with checkpatch from the linux
>  +   kernel. It helps you to spot trivial formating errors.
>  +

Consider checking your spelling, too?  ;-)


Dave.
