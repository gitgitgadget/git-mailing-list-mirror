From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What is the whole process of cooking git as a maintainer?
Date: Wed, 21 Nov 2007 21:17:59 +0800
Message-ID: <46dff0320711210517y282643a2q62819d3583ec9344@mail.gmail.com>
References: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IupTF-0000nH-MA
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbXKUNSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 08:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbXKUNSH
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:18:07 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:44143 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXKUNSG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 08:18:06 -0500
Received: by py-out-1112.google.com with SMTP id u77so7178500pyb
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xNPyPRC8vWQ4cKnhba2v91tO4HwDOBjQxDBZ8lK7eNw=;
        b=ZYyqMSQtfLnzKKQeW/VqhupP5x97qcZBDcXhBJ5Xgktmo9tUpXIQh0bEdFUBEmOjb2aPg7x2kW8W/nOx2oXuezThbvgQbj0NgtoKagVF8Ockd9t+K43FSZ4RdYft1E77ARgq6lrdnM26xhASgk1SL9ZZUIpSgeKulSlr4J0Wfqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B8Gv51AXlqoSYGkuUu4g0dVo+ZUpOfxlOO6kTdUOgnAVT695bEpNCjn0XNe4CTTEeWlmCWYMtdKffAVrz/AVCxNIy6Dz/MA6QJMzqIKqk6iw5evTNAxdXhBBYauzWYojk2stcvzqh+tQMOmUmW0AX4X/XJJKv624ON99G7WH+Fo=
Received: by 10.35.68.3 with SMTP id v3mr8997453pyk.1195651079480;
        Wed, 21 Nov 2007 05:17:59 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 21 Nov 2007 05:17:59 -0800 (PST)
In-Reply-To: <46dff0320711210511g7d9febf5k47b082cc13bb905a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65646>

On Nov 21, 2007 9:11 PM, Ping Yin <pkufranky@gmail.com> wrote:
> I have scanned the manual and found a 'Linux subsystem maintainer'
> example. However, that's a little brief and i wonder a more real
> example. I think an example of how to cook git as a maintainer is
> better.
>
> Junio , could you please share the whole process of cooking among pu,
> next and master? Or, can i find this in the mail list archive?
>
> For example:
> In which branch the test is performed?
> How to rewind pu?
> How to merge a subset of changes from pu to next, and from next to master?
>

One more question:
I see so many merges in pu branch, but where these merges go when a
feature is moved to the master branch?
>
> --
> Ping Yin
>



-- 
Ping Yin
