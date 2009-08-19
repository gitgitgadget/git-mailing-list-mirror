From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 12/12] Add gitignore and ReadMe file for MSVC Build
Date: Wed, 19 Aug 2009 18:00:44 +0200
Message-ID: <40aa078e0908190900t451fcc76y4a460045a8cb6cc7@mail.gmail.com>
References: <1250697475-4340-1-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 18:00:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mdnan-0005NO-2i
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 18:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZHSQAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 12:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbZHSQAo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 12:00:44 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:54085 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbZHSQAn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 12:00:43 -0400
Received: by qyk34 with SMTP id 34so3361805qyk.33
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s6lHoqkxp+X9EZN38NBFf0QyATafQD4UKOZ4+Ll6Nl4=;
        b=MLCJlryY+Aa1azyfnwqGWbOSbBFauNP7nvkpOw5Zpbw5ZyxWesgIBK9yvBte/9Amz5
         tM+W1D/Tu9nT+3ZLmahuD9D1pSGnrbkR0SHFfkNivS3KHDp8r/K2w7YUUu7s48oE0Ucz
         MlwTLoZCxbwSEISNLK50HaSkNAP0xwa5Mtv9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GAgXa71pn12DkEw1Hk9rtzpOxvJAOiQy1WSU+BKpul0b71WstZ1iD+j/xkZfekLl1d
         clFu9K6lfZTharfnusr0FL0MXP79oQ/MEmjLv1JXUk3EZOopYs/rhDSkH9ZCV0NJb9U1
         Wq4pA8wUo1SThqCGaqmwInIPoiD0TiyurbgJE=
Received: by 10.224.16.131 with SMTP id o3mr6621889qaa.18.1250697644250; Wed, 
	19 Aug 2009 09:00:44 -0700 (PDT)
In-Reply-To: <1250697475-4340-1-git-send-email-lznuaa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126564>

On Wed, Aug 19, 2009 at 5:57 PM, Frank Li<lznuaa@gmail.com> wrote:
> +3. Open gitbuild\gitbuild.sln with VS2008. Then press F7.
> \ No newline at end of file

Again, please add a newline.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
