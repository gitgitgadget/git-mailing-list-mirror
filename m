From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Hosting from Windows XP.
Date: Tue, 27 Jan 2009 01:44:16 +0800
Message-ID: <be6fef0d0901260944l7e128588xc560810515e5f941@mail.gmail.com>
References: <c115fd3c0901260827ge5e4b29w871b345da2373f6b@mail.gmail.com>
	 <alpine.DEB.1.00.0901261744240.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tim Visher <tim.visher@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 18:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRVWp-0002Oj-Se
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 18:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbZAZRoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 12:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbZAZRoS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 12:44:18 -0500
Received: from rv-out-0506.google.com ([209.85.198.229]:39280 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbZAZRoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 12:44:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so5947909rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 09:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HLDsCuV/jiJN/AnMpn8LV2RxRL0tcPXY4b9slSvqXUk=;
        b=crLvMtUHErGusIiXjWXczruDrkItSsz+KuOEGvKUysyxQSe4hZmrk/q2EFRW8o/Lni
         mseF4hGDzrwzaMxrXBk76yGiyOauJBIf+d+NmWGUEvTa2ic1X1ywcQeoOHC5CizO7YkL
         PebaXp4IXzO60Rb1wD+SDiOJqkpOjjFMDdWqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F7HuNBp2RN927lTNrhb98WsiMJYRT/Q+b06JqEGXoN2gsCY+PDwRGTnHNiErYzYHzE
         b1y4FAfRlG0RjvN/TG0WhM0Pt0/i0vD6Bz54Q74SitCLeCy1/Q4+AxPjcK4DnpAv0fCI
         rv4GFq7R2rbCbjtT/zsvEoB0bm1bQvy/sqBSA=
Received: by 10.115.18.3 with SMTP id v3mr2754863wai.32.1232991856712; Mon, 26 
	Jan 2009 09:44:16 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901261744240.25749@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107236>

Hi,

On Tue, Jan 27, 2009 at 12:45 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Use a net share.  Use the native permission system to restrict/open up the
> repository for certain people to read from/write to.

hmm, does this entail git daemon usage too?

-- 
Cheers,
Ray Chuan
