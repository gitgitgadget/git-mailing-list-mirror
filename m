From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] qgit: Default the log window to wider than the file list and set monospaced font
Date: Thu, 8 Feb 2007 21:58:55 +0000
Message-ID: <200702082158.56463.andyparkins@gmail.com>
References: <200702072138.36787.andyparkins@gmail.com> <e5bfff550702081129x6c94eaa4p40cf09e70c4e09cd@mail.gmail.com> <e5bfff550702081151q5536b547p34728cafa9a7dee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 23:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFHL6-00080l-JC
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbXBHWB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945903AbXBHWB4
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:01:56 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:56665 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945912AbXBHWBz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:01:55 -0500
Received: by nz-out-0506.google.com with SMTP id s1so608695nze
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 14:01:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OMu0kJ2g0GvzvlRFFxuZUKc99MBnDt+5/pGTBMKXV2mZcG3LIKq0dXjO1Cf3gcOYYhJQDhGGgVGFmJ0hc9Zj7xT782fsIvIT4g6C48MQTSaiu4D1hUFIKvbAGjs5FDS6NPsH9Bn/m4bRGoYxjX/w7FoKtq9q6I+CSWk6j50Tqcc=
Received: by 10.35.110.13 with SMTP id n13mr23480615pym.1170972114214;
        Thu, 08 Feb 2007 14:01:54 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id z21sm2904965qbc.2007.02.08.14.01.50;
        Thu, 08 Feb 2007 14:01:51 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <e5bfff550702081151q5536b547p34728cafa9a7dee@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39100>

On Thursday 2007, February 08 19:51, Marco Costalba wrote:

> BTW it's a little bit funny when you try to resize with mouse the
> author column and see short log column moving instead :-)

Yeah, I'm not entirely sure I like it.  What I really want, but Qt won't 
do it is
 * all columns resizable
 * default date width to fit contents
 * columns always take up whole width of view, never introducing a 
   horizontal scrollbar

If you want to drop it, I won't be upset.  It is very disconcerting, the 
only thing in that patches favour is that the view starts out basically 
correct.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
