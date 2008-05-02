From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] Make boundary characters for --color-words configurable
Date: Fri, 2 May 2008 22:27:43 +0800
Message-ID: <46dff0320805020727x7609826cm75d91f5c525dd5a2@mail.gmail.com>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>
	 <1209736766-8029-1-git-send-email-pkufranky@gmail.com>
	 <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Ping Yin" <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 16:29:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrwFU-0001IU-Rf
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 16:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686AbYEBO1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 10:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758279AbYEBO1p
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 10:27:45 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:37750 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753543AbYEBO1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 10:27:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so313473and.103
        for <git@vger.kernel.org>; Fri, 02 May 2008 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=35cP2GrUNWgkYowQ/dgJJKb3snlAXG3CH9kv8gtosns=;
        b=EIzDtZ9dwlJYj10RvqUs8ePLNtAk/pERryx5RTba6NXy1bZxfCfe1U3M8mLSa40OsA10w6V7wQvLD0LaPBKAG+el63sow/gSfNVKGl4hvBrgKY1hD7dZJnA8mBu9vAsXfx+O69NNxxq1ahlk8Y8hx1raAqvVeEBjy5K4ANXhQVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QwodI2Tx+VaVWMYNID2kBckySNmBmt46yGgmp3Z7Q5fJINPvnaD3Cxy1QWF2xcRQFrmnFqMuiGwqPZRk0mlEUCPyWr5lpgd2g4wZN4rKQUxl1/k5V12DVhNC5MnNiZNLi/OGXly5ZcTPUmSKOujf0R+z1CEszgCf6pj0l59EDPw=
Received: by 10.100.105.15 with SMTP id d15mr4636355anc.149.1209738463884;
        Fri, 02 May 2008 07:27:43 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 2 May 2008 07:27:43 -0700 (PDT)
In-Reply-To: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81003>

On Fri, May 2, 2008 at 10:26 PM, Ping Yin <pkufranky@gmail.com> wrote:

>  bar should show in the same line with bar. This is not related to my patch.

s/with bar/with foo/


-- 
Ping Yin
