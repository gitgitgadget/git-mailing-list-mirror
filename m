From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Documentation: merging a tag is a special case
Date: Thu, 21 Mar 2013 15:41:20 -0700
Message-ID: <20130321224120.GC12223@google.com>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
 <7vboadevpk.fsf@alter.siamese.dyndns.org>
 <7vmwtwa5xa.fsf@alter.siamese.dyndns.org>
 <20130321195624.GH29311@google.com>
 <7vehf8a4ze.fsf@alter.siamese.dyndns.org>
 <1363902468-14764-1-git-send-email-ydroneaud@opteya.com>
 <1363903068-15905-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Thu Mar 21 23:41:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIoBI-0003ap-8i
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 23:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932846Ab3CUWl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 18:41:27 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:50480 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab3CUWlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 18:41:25 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so1896055dak.2
        for <git@vger.kernel.org>; Thu, 21 Mar 2013 15:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LLnzRu+qkKcIwWImGDagXOaQXMTrws18ZyHOVaXXzoA=;
        b=MHXtDJzOwQcxSpNm80LRBw+CLKr1iIZmbD4Tm5wOQmF6kIB0fBl0MwyPNdMp3UEG2p
         c5nNHF1v9TUx/vWILzjtcAG8s4EztYQiXn/fDlWx/WnnnjxjVx6/KGxZoNSg6PgQOncR
         XOvN5zI8bdaTN/ME5RJzCIvhLz3GH3jc0H+mm3RKsYMaF+0skc/wSHl1CKruyjj245yd
         1wFabNNMyNxWJxzfrD0tRbsbrZk4251LFmZ/unCbur0CZ/lNb7x+yKu0+tC/nOfpht3d
         OL4gWUklUovCi5PGKPQ4B/4EGTI7L1/XAbx1P8CbFET2g7DFlcMpLTEf3HRXOTa9F1b+
         oUvQ==
X-Received: by 10.66.252.162 with SMTP id zt2mr59608pac.1.1363905684823;
        Thu, 21 Mar 2013 15:41:24 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rt13sm262198pac.14.2013.03.21.15.41.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 Mar 2013 15:41:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363903068-15905-1-git-send-email-ydroneaud@opteya.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218770>

Yann Droneaud wrote:

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yes, I think this is in good shape now.
