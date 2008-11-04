From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Tue, 4 Nov 2008 08:38:05 -0500
Message-ID: <9e4733910811040538v604d33e3jf0b312d809630af2@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 14:39:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxM7y-0001cZ-HZ
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 14:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbYKDNiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 08:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYKDNiI
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 08:38:08 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:47459 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbYKDNiF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 08:38:05 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3278692rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 05:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ij/b1x7yC4vBixSTzUS/Kdh/gQMDmWLo+zIKf9vuKk8=;
        b=bkUxl5TzNJ1xKG+seudBZ/4Mca/7tAjKTlHCLoAuNseDlIIDmuOalS4xqoSg/NT0CA
         BaKNC5IMqucH4pICLxHGrXj92JZ3zVOfIp+6VcY1GqOGAGhkq9rwVFFLC9C0FFOSCukC
         YyUp7JZshsEWAU5kVXqCeSsmh1daCyFBPZrC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sbl0VlcF6GkuccKf7majkbxy5bNSCiit75BGtJol4Asek6/z0+27z0djMsZr3tUt48
         5QcE5gbmg7yJ7p5UcIWRBzm87+8MaMbFLS7XAUNXqSVDo66Qy31KdLRLcr1y5ExiK4eu
         ymJ1SOnAXJzqgsXfeEf2ASQbXO87NuOTs5JeM=
Received: by 10.141.164.13 with SMTP id r13mr870589rvo.53.1225805885347;
        Tue, 04 Nov 2008 05:38:05 -0800 (PST)
Received: by 10.140.208.10 with HTTP; Tue, 4 Nov 2008 05:38:05 -0800 (PST)
In-Reply-To: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100078>

jonsmirl@terra:~/fs$ stg version
Stacked GIT 0.14.3.270.g0f36
git version 1.6.0.3.523.g304d0
Python version 2.5.2 (r252:60911, Oct  5 2008, 19:29:17)
[GCC 4.3.2]
jonsmirl@terra:~/fs$

-- 
Jon Smirl
jonsmirl@gmail.com
