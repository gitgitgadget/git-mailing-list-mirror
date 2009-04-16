From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Building statically linked binary
Date: Thu, 16 Apr 2009 09:12:33 -0400
Message-ID: <76718490904160612j3c503d27o97e055a1e4d35aab@mail.gmail.com>
References: <loom.20090416T104327-682@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avo <avo@laborint.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 15:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuRQM-0006G0-1j
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 15:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbZDPNMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 09:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755827AbZDPNMe
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 09:12:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:19398 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470AbZDPNMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 09:12:34 -0400
Received: by rv-out-0506.google.com with SMTP id b25so3019933rvf.5
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZvL3hZTq9p4nj0Xd5A1g4/Log9sicqM3Adaj4e8c7do=;
        b=D+z3UrDFOlQt9slre/sT+QmGIj6IBkeErrWv41j1nbTWJtfpw0Z1EY9xKv86s9cE3q
         X8v6X2IhKmL1teX7kBhjSU83F8J+ko2isbOBjaymfFzGM0N/MBQYCfOkTeHPWSL1YJqy
         6mvE6GCiwROH9T6CUCGWRtR2rR9uJ8aZscq+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f+XRfagdMndzgRxubT82PBwLNV591yT7xnbdsEydiRWHouj6oXilGYmwVKPK0e0SlL
         N50PQTyySI3loBr4YNjAsYtoBlTPc7spywPBgLibaN4o3W78AFCYXxnC8gQ34FsjdcgK
         W80UyiHCuxV05H+LOKumTbLZeybVbT6NglBNY=
Received: by 10.140.132.3 with SMTP id f3mr791985rvd.21.1239887553691; Thu, 16 
	Apr 2009 06:12:33 -0700 (PDT)
In-Reply-To: <loom.20090416T104327-682@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116699>

On Thu, Apr 16, 2009 at 6:46 AM, Avo <avo@laborint.com> wrote:
> If yes, please give me some hints.

Hint: static linking is platform dependent.

j.
