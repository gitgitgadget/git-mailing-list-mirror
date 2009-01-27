From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: Anyone have access to 64-bit Vista?
Date: Tue, 27 Jan 2009 15:59:01 -0800
Message-ID: <83d7aaa40901271559y2767c6aes3fbecb28a88f4759@mail.gmail.com>
References: <83d7aaa40901270130g3bebb3d6we4839b567f310e46@mail.gmail.com>
	 <20090127122456.0df531c3.stephen@exigencecorp.com>
	 <83d7aaa40901271441h47c98edepc16f5026de636134@mail.gmail.com>
	 <alpine.DEB.1.00.0901272350360.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 01:00:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRxrD-0005Fr-IO
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 01:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbZA0X7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbZA0X7F
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:59:05 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:52561 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbZA0X7C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:59:02 -0500
Received: by qyk4 with SMTP id 4so7625868qyk.13
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 15:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=m9o9tk8krjffqn6a5aFCMsvpQXRRvp7Vb8pvedJdDhE=;
        b=aZiOtGHjlV1mTAqB7jp2SIcL0sgI6VhhYs9uX4FJk6g6iZTIJfuWU4nLDpyeBpCwcD
         s/mAsQCJyB8ICYWZWM7oPV8RJmMlfcBQWijfaT+h34DFdlopPR5JccNf1/x85w9TiCgm
         qBb7Fd8tFSKFclMrY4zC6Rj8ahLL/GpVEG8S0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=fShWBgyqKPIxDbQquUcYtMICDkjFb3pt0ByAFoAvoYprUc3AQeUjPZgiu0kWnqBOg3
         hpWonjHU/GVBldLeMKaxD7Up6JBl4ysqBc3dqUS0BY96GEvFcLn0IiO8HZ8rKRXbZ+Uc
         zih59K3jnnEmAlN+S4HhPM6ozDs2xWddnDSHo=
Received: by 10.214.113.21 with SMTP id l21mr2951649qac.182.1233100741215; 
	Tue, 27 Jan 2009 15:59:01 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901272350360.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107429>

On Tue, Jan 27, 2009 at 2:51 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> How could it?  You cannot have 32-bit code and 64-bit code running in the
> same process.  At least not with x86_64 (AFAIK).

Yeah it seems obvious now, but I had gotten used to 64-bit Windows
being able to run 32-bit apps so seamlessly that I didn't think about
it.

-Geoffrey Lee
